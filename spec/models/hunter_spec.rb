require 'rails_helper'

RSpec.describe Hunter, type: :model do
  let(:hunter) { create(:hunter) }

  describe '#available_improvements' do
    subject { hunter.available_improvements }

    context 'improvement outside playbook' do
      let!(:improvement) { create :improvement, playbook: create(:playbook) }

      it { is_expected.not_to include(:improvement) }
    end

    context 'improvement matches hunter playbook' do
      let!(:improvement) { create(:improvement, playbook: hunter.playbook) }

      it { is_expected.to include(improvement) }
      context 'hunter already has improvement' do
        let!(:hunters_improvement) { create(:hunters_improvement, hunter: hunter, improvement: improvement) }

        it { is_expected.not_to include(:improvement) }
      end
    end
  end

  describe '#gain_experience' do
    subject { hunter.gain_experience(exp) }

    let(:exp) { 1 }
    it 'increases the hunter experience' do
      expect { subject }.to change(hunter.reload, :experience).by(1)
      expect(hunter.reload.experience).to eq 1
    end
  end
end