# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { FactoryBot.create(:question) }

  describe 'GET #index' do
    before do
      @questions = FactoryBot.create_list(:question, 3)
      get :index
    end

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(@questions)
    end
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question.id } }

    it 'assigns the requested to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'render show views' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assign a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render views new' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: question.id } }

    it 'assigns edit object Questions' do
      expect(assigns(:question)).to eq question
    end
    it 'render views edit' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        old_question_count = Question.count
        post :create, params: { question: FactoryBot.attributes_for(:question) }
        expect(Question.count).to eq old_question_count + 1
      end
      it 'render question show views' do
        post :create, params: { question: FactoryBot.attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
    context 'with invalid attributes' do
      it 'do not saving new question' do
        old_question_count = Question.count
        post :create, params: { question: FactoryBot.attributes_for(:invalid_question) }
        expect(response).to_not eq old_question_count + 1
      end
      it 'redirect to view new' do
        post :create, params: { question: FactoryBot.attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end
  describe 'PATCH #update' do
    context 'valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, params: { id: question.id, question: FactoryBot.attributes_for(:question) }
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update,
              params: { id: question.id, question: {title: 'new title', body: 'new body'} }
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to the updated question(show)' do
        patch :update, params: { id: question.id, question: FactoryBot.attributes_for(:question) }
        expect(response).to redirect_to question
      end
    end

    context 'invalid attributes' do
      before { patch :update, params: { id: question.id, question: { title: nil, body: nil } } }
      it 'does not change question attributes' do
        question.reload
        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyText'
      end

      it 'render form for update' do
        expect(response).to render_template :edit
      end
    end
  end
  describe 'DELETE #destroy' do
    it 'delete question' do
      question
      old_question_count = Question.count
      delete :destroy, params: { id: question.id }
      expect(Question.count).to eq old_question_count - 1
    end
    it 'redirect index' do
      delete :destroy, params: { id: question.id }
      expect(response).to redirect_to questions_url
    end
  end
end
