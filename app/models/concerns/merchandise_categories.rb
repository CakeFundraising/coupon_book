module MerchandiseCategories
  extend ActiveSupport::Concern

  CATEGORIES = [
  	'Adventure, Sports & Outdoors',
    'Animals & Pets',
    'Arts & Crafts',
    'Baby & Children',
    'Beauty, Spa & Salon',
    'Boats & Airplanes',
    'Books & Publications',
    'Business, Sales & Entrepreneurship',
    'Cars, Trucks & Vehicles',
    'Cash & Credits',
  	'Classes & Education',
    'Clothing, Shoes & Fashion',
    'Collectibles & Antiques',
    'Computers & Software',
    'Consumer Electronics',
    'Credit Cards, Loans & Banking',
    'Downloads & Subscriptions',
    'Farm & Agricultural',
    'Food, Drink & Dining',
    'Grocery & Merchandise',
    'Home, Garden & Tools',
    'Industry, Equipment & Commerce',
    'Internet & Websites',
    'Legal & Accounting',
    'Medical, Health & Treatments',
  	'Military & Government',
    'Mortgage & Insurance',
  	'Movies, Music & Games',
    'Personal Services',
    'Phone, Utility & Services',
    'Planning, Investing & Trading',
  	'Travel & Accommodations',
  	'Tickets & Events',
   	'Transportation & Shipping'
  ]

  def merchandise_categories=(merchandise_categories)
    merchandise_categories = merchandise_categories.split(",") if merchandise_categories.is_a?(String)
    self.merchandise_categories_mask = (merchandise_categories & CATEGORIES).map { |r| 2**CATEGORIES.index(r) }.inject(0, :+)
  end

  def merchandise_categories
    CATEGORIES.reject do |r|
      ((merchandise_categories_mask.to_i || 0) & 2**CATEGORIES.index(r)).zero?
    end
  end

  def has_merchandise_category?(merchandise_category)
    merchandise_categories.include?(merchandise_category)
  end
end