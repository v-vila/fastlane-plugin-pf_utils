describe Fastlane::Actions::PfUtilsAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The pf_utils plugin is working!")

      Fastlane::Actions::PfUtilsAction.run(nil)
    end
  end
end
