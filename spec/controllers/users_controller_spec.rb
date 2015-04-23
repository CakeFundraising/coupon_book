RSpec.describe UsersController, type: :controller do
  describe 'POST #new_session' do
    context "Valid Crendentials" do
      let!(:action_call) { post :new_session, user: attributes_for(:user_credential) } 

      it "should store access_token in session" do
        action_call
        expect(session[:access_token]).to_not be_nil
      end

      it "should redirect to root_path" do
        expect(action_call).to redirect_to(root_path)
      end
    end

    context "Invalid Crendentials" do
      let!(:action_call) { post :new_session, user: attributes_for(:invalid_credential) } 

      it "should not store access_token in session" do
        action_call
        expect(session[:access_token]).to be_nil
      end

      it "should redirect to root_path" do
        expect(action_call).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE #sign_out" do
    let!(:action_call) { delete :sign_out }

    it "should delete access_token from session" do
      action_call
      expect(session).to_not have_key(:access_token)
    end

    it "should redirect to root_path" do
      expect(action_call).to redirect_to(root_path)
    end
  end
end