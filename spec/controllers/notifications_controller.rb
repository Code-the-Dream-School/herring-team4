require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let(:user) { create(:user) }
  let(:notification) { create(:notification, user: user) }

  before do
    sign_in user
  end

  describe "GET #new" do
    it "assigns a new notification to @notification" do
      get :new
      expect(assigns(:notification)).to be_a_new(Notification)
    end
  end

  describe "GET #show" do
    it "assigns the requested notification to @notification" do
      get :show, params: { id: notification.id }
      expect(assigns(:notification)).to eq(notification)
    end

    it "renders the :show template" do
      get :show, params: { id: notification.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #edit" do
    it "assigns the requested notification to @notification" do
      get :edit, params: { id: notification.id }
      expect(assigns(:notification)).to eq(notification)
    end

    it "renders the :edit template" do
      get :edit, params: { id: notification.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new notification" do
        expect {
          post :create, params: { notification: attributes_for(:notification) }
        }.to change(Notification, :count).by(1)
      end

      it "redirects to the created notification" do
        post :create, params: { notification: attributes_for(:notification) }
        expect(response).to redirect_to(Notification.last)
      end
    end

    context "with invalid attributes" do
      it "does not create a new notification" do
        expect {
          post :create, params: { notification: { hour: nil, minute: nil, ampm: nil, days_of_week: [] } }
        }.to_not change(Notification, :count)
      end

      it "renders the :new template" do
        post :create, params: { notification: { hour: nil, minute: nil, ampm: nil, days_of_week: [] } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the notification" do
        patch :update, params: { id: notification.id, notification: { hour: 9, minute: 30, ampm: "AM", days_of_week: ["Monday", "Wednesday"] } }
        notification.reload
        expect(notification.hour).to eq(9)
        expect(notification.minute).to eq(30)
        expect(notification.ampm).to eq("AM")
        expect(notification.days_of_week).to eq(["Monday", "Wednesday"])
      end

      it "redirects to the updated notification" do
        patch :update, params: { id: notification.id, notification: { hour: 9, minute: 30, ampm: "AM", days_of_week: ["Monday", "Wednesday"] } }
        expect(response).to redirect_to(notification)
      end
    end

    context "with invalid attributes" do
      it "does not update the notification" do
        patch :update, params: { id: notification.id, notification: { hour: nil, minute: nil, ampm: nil, days_of_week: [] } }
        notification.reload
        expect(notification.hour).not_to be_nil
        expect(notification.minute).not_to be_nil
        expect(notification.ampm).not_to be_nil
      end

      it "renders the :edit template" do
        patch :update, params: { id: notification.id, notification: { hour: nil, minute: nil, ampm: nil, days_of_week: [] } }
        expect(response).to render_template(:edit)
      end
    end
  end
end
