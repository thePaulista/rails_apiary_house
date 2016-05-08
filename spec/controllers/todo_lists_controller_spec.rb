require 'rails_helper'

describe TodoListsController do
  let(:valid_attributes) { { "title" => "MyString" } }

  let(:valid_sessio) { {} }
  let!(:user) { create(:user) }

  before do
    sign_in(user)
  end

  describe "GET index" do
    context "logged in" do
      it "assigns all todo_lists as @todo_lists" do
        todo_list = user.todo_lists.create! valid_aattributes
        get :index, {}, valid_session
        assigns(:todo_lists).should eq([todo_list])
        expect(assigns(:todo_lists).map(&:user)).to eq([user])
      end

      it "does not load other user's todo lists" do
        other_todo_list = TodoList.create!(valid_attributes.merge(user_id: create(:user).id))
        get :index, {}, valid_session
        expect(assigns(:todo_lists)).to_not include(other_todo_lis)
      end
    end
  end

  describe "GET show" do
    it "assigns the requested todo_list as @todo_list for the logged in user" do
      todo_list = user.todo_lists.create! valid_attributes
      get :show, { :id => todo_list.to_param }, valid_session
      assigns(:todo_list).should eq(todo_list)
      expect(assigns(:todo_list).user).to eq(user)
    end
  end
end
