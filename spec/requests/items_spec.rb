require 'rails_helper'

RSpec.describe 'Items API' do
  items_length = 20
  accepted_response = 200
  does_not_exist = 404
  created = 201
  unprocessable = 422
  no_content = 204
  no_items = 0
  no_method_backup = 420
  # -------------------------------------------------------------
  # Initialize the test data.
  let!(:todo) { create(:todo) }
  let!(:items) { create_list(:item, items_length, todo_id: todo.id) }
  let(:todo_id) { todo.id }

  begin
    let(:id) { items.first.id }
  rescue NoMethodError
    let(:id) { no_method_backup }
  end

  # -------------------------------------------------------------
  # Test suite for GET /todos/:todo_id/items
  describe 'GET /todos/:todo_id/items' do
    before { get "/todos/#{todo_id}/items" }

    # ---------------------
    context 'when todo exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(accepted_response)
      end

      it 'returns all todo items' do
        expect(json.size).to eq(items_length)
      end
    end

    # ---------------------
    context 'when todo does not exist' do
      let(:todo_id) { no_items }

      it 'returns status code 404' do
        expect(response).to have_http_status(does_not_exist)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # -------------------------------------------------------------
  # Test suite for GET /todos/:todo_id/items/:id
  describe 'GET /todos/:todo_id/items/:id' do
    before { get "/todos/#{todo_id}/items/#{id}" }

    # ---------------------
    context 'when todo item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(accepted_response)
      end

      it 'returns the item' do
        expect(json['id']).to eq(id)
      end
    end

    # ---------------------
    context 'when todo item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(does_not_exist)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # -------------------------------------------------------------
  # Test suite for PUT /todos/:todo_id/items
  describe 'POST /todos/:todo_id/items' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false } }

    # ---------------------
    context 'when request attributes are valid' do
      before { post "/todos/#{todo_id}/items", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(created)
      end
    end

    # ---------------------
    context 'when an invalid request' do
      before { post "/todos/#{todo_id}/items", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(unprocessable)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # -------------------------------------------------------------
  # Test suite for PUT /todos/:todo_id/items/:id
  describe 'PUT /todos/:todo_id/items/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before { put "/todos/#{todo_id}/items/#{id}", params: valid_attributes }

    # ---------------------
    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(no_content)
      end

      it 'updates the item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Mozart/)
      end
    end

    # ---------------------
    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(does_not_exist)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # -------------------------------------------------------------
  # Test suite for DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}/items/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(no_content)
    end
  end
end
