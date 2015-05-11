class CouponBooksController < InheritedResources::Base
  TEMPLATE_STEPS = [
    :basic_info,
    :tell_your_story,
    :coupons,
    :launch_coupon_book,
    :share
  ]

  def index
    @coupon_books = current_fundraiser.coupon_books.latest.decorate
  end

  def show
  end

  #Template steps
  def basic_info
    @coupon_book = resource.decorate
    render 'coupon_books/template/basic_info'
  end

  def tell_your_story
    @coupon_book = resource.decorate
    render 'coupon_books/template/tell_your_story'
  end

  #Build coupon book
  def coupons
    @coupon_book = resource

    @collection = Collection.first_or_create!
    # @collection = current_fundraiser.coupon_collection || current_fundraiser.create_coupon_collection
    @collections_coupons = @collection.coupons.latest.decorate

    @categories = resource.categories.with_coupons.decorate

    render 'coupon_books/template/coupons'
  end

  #Launch
  def launch_coupon_book
    @coupon_book = resource.decorate
    render 'coupon_books/template/launch'
  end

  def share
    @coupon_book = resource.decorate
    render 'coupon_books/template/share'
  end

  #Default actions
  def create
    @coupon_book = current_fundraiser.coupon_books.build(*resource_params)

    create! do |success, failure|
      success.html do
        redirect_to tell_your_story_coupon_book_path(@coupon_book)
      end
      failure.html do
        render action: :new
      end
    end
  end

  def update
    update! do |success, failure|
      success.html do
        redirect_to controller: :coupon_books, action: params[:coupon_book][:step], id: resource
      end
      failure.html do
        step_action = TEMPLATE_STEPS[TEMPLATE_STEPS.index(params[:coupon_book][:step].to_sym)-1].to_s
        render 'coupon_books/template/' + step_action
      end
    end
  end

  def destroy
    destroy! do |success, failure|
      success.html do
        redirect_to coupon_books_path, notice: 'Coupon book was successfully destroyed.'
      end
    end
  end

  def update_coupon_book_order
    @coupon_book = CouponBook.find(params[:id])
    book_categories = Category.where(coupon_book_id: @coupon_book.id)

    params[:categories].each do |id, category|
      position = category[:position]
      c = Category.find_by_id(id)
      c.insert_at(position.to_i)
    end


    filter = []
    if params[:categories_coupons]
      params[:categories_coupons].each do |id, category_coupon|
        position = category_coupon[:position]
        category = category_coupon[:category_id]
        coupon = category_coupon[:coupon_id]

        category_coupon = CategoriesCoupon.find_by_id(id)
        filter.push(id.to_i)

        if category_coupon.present?
          category_coupon.update_attributes(position: position, category_id: category)
          category_coupon.insert_at(position.to_i)

        else
          book_categories.each do |bc|
            CategoriesCoupon.where(category_id: bc, coupon_id: coupon).delete_all
          end
          category_coupon = CategoriesCoupon.create!(coupon_id: coupon, category_id: category, position: position)
          filter.push(category_coupon.id.to_i)
          category_coupon.insert_at(position.to_i)
        end
      end
    end


    cat_ids = []
    book_categories.each do |bc|
      cat_ids.push(bc.id)
    end

    @unused_coupons = CategoriesCoupon.select { |coupon|  cat_ids.include?(coupon.category_id) and (not filter.include?(coupon.id)) }

    @unused_coupons.each do |unused_coupon|
      CategoriesCoupon.destroy(unused_coupon.id)
    end

    redirect_to @coupon_book
  end

  #Special Actions
  def save_for_launch
    resource.pending!
    redirect_to share_coupon_book_path(resource), notice: 'Coupon Book saved!'
  end

  def launch
    resource.launch!
    #update_coupon_book_screenshot(resource)

    if request.xhr?
      render nothing: true
    else
      redirect_to share_coupon_book_path(resource), notice: 'Coupon Book launched!'
    end
  end

  def toggle_visibility
    resource.toggle! :visible
    render nothing: true
  end

  private

  def permitted_params
    params.permit(coupon_book: [:name, :mission, :launch_date, :end_date, :story, :custom_pledge_levels, :goal,
      :headline, :step, :url, :main_cause, :sponsor_alias, :visitor_url, :visitor_action, :visible, causes: [],
      scopes: [], video_attributes: [:id, :url, :auto_show],
      picture_attributes: [
        :id, :banner, :avatar, :avatar_caption,
        :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h,
        :banner_crop_x, :banner_crop_y, :banner_crop_w, :banner_crop_h
      ],
      categories_attributes: [:position]
    ])
  end

end
