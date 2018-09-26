require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  describe 'Document' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
  end

  describe 'Fields' do
    it { is_expected.to have_field(:ad_type).of_type(Symbol) }
    it { is_expected.to have_field(:title).of_type(String) }
    it { is_expected.to have_field(:location).of_type(String) }
    it { is_expected.to have_field(:description).of_type(String) }
    it { is_expected.to have_field(:price).of_type(Float) }
    it { is_expected.to have_field(:author_name).of_type(String) }
    it { is_expected.to have_field(:author_email).of_type(String) }
    it { is_expected.to have_field(:author_phone).of_type(String) }
    it { is_expected.to have_field(:terms_of_service).of_type(Mongoid::Boolean) }
    it { is_expected.to have_field(:admin_token).of_type(String) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:ad_type) }
    it { is_expected.to validate_inclusion_of(:ad_type).to_allow(*Advertisement::TYPES) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).with_minimum(2).with_maximum(100) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).with_minimum(2).with_maximum(3000) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).greater_than(0) }
    it { is_expected.to validate_presence_of(:author_name) }
    it { is_expected.to validate_length_of(:author_name).with_minimum(2).with_maximum(100) }
    it { is_expected.to validate_presence_of(:author_email) }
    it { is_expected.to validate_presence_of(:author_phone) }
    it { is_expected.to validate_length_of(:location).with_minimum(2).with_maximum(100) }
    it { is_expected.to validate_acceptance_of(:terms_of_service) }
  end

  describe 'Custom Validations' do
    describe 'validate_author_email' do
      context 'when the author email is invalid' do
        before do
          @advertisement = build(:advertisement, author_email: 'dsdsds@')
        end

        it 'should be invalid' do
          expect(@advertisement).to be_invalid
        end
      end

      context 'when the author email is valid' do
        before do
          @advertisement = build(:advertisement)
        end

        it 'should be valid' do
          expect(@advertisement).to be_valid
        end
      end
    end
  end

  describe 'Methods' do
    before do
      @advertisement = build(:advertisement)
    end

    describe '#generate_admin_token' do
      it 'should generate the admin token' do
        expect(@advertisement.admin_token).to be nil
        @advertisement.save
        expect(@advertisement.admin_token).not_to be nil
      end
    end

    describe '#send_email' do
      it 'should be send a email to ad author' do
        expect { @advertisement.save }.to have_enqueued_job.on_queue('mailers')
      end
    end
  end
end
