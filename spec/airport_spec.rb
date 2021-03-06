require 'airport'

describe Airport do
    
  let(:test_plane) { double :plane, landed?: true, take_off: nil }

  before do
    allow(subject).to receive(:weather_conditions).and_return 'sunny'
  end

  describe 'take off' do

    it 'instructs a plane to take off' do
      expect(test_plane).to receive :take_off

      subject.instruct_land test_plane

      subject.instruct_take_off test_plane
    end

    it 'releases a plane when it was the last plane that landed' do
      subject.instruct_land test_plane
      subject.instruct_take_off test_plane
      expect(subject.landed_planes).to be_empty
    end

    it 'releases specific plane, even if not last to land' do
      filler_plane1 = double :plane, landed?: true

      [test_plane, filler_plane1].each do |plane|
        subject.instruct_land plane
      end
      
      expect(subject.instruct_take_off test_plane).to eq test_plane
    end

    it 'cannot tell a plane to take off if airport is empty' do
      expect { subject.instruct_take_off test_plane }.
        to raise_error 'No planes to take off'
    end
  end

  describe 'landing' do
    it 'instructs a plane to land' do # implement this test as we did above with take off
      expect(subject).to respond_to(:instruct_land).with(1).argument
    end

    it 'receives a plane' do
      subject.instruct_land test_plane
      expect(subject.landed_planes).to include test_plane
    end
  end

  describe 'capacity' do
    it 'has a (default) maximum capacity' do
      expect(subject.capacity).to eq Airport::DEFAULT_CAPACITY
    end

    it 'airport has no landed planes when created' do
      expect(subject.landed_planes).to be_empty
    end
  end

  describe 'traffic control' do
    context 'when airport is full' do
      it 'does not allow a plane to land' do
        subject.capacity.times { subject.instruct_land test_plane }
        expect { subject.instruct_land double :plane }.to raise_error
        "Airport is full"
      end
    end

    context 'when weather conditions are stormy' do
      it 'does not allow a plane to take off' do
        allow(subject).to receive(:weather_conditions).and_return('stormy')
        expect { subject.instruct_take_off double :plane }.to raise_error
        'Planes cannot take off during stormy weather'
      end

      it 'does not allow a plane to land' do
        allow(subject).to receive(:weather_conditions).and_return('stormy')
        expect { subject.instruct_land double :plane }.to raise_error
        'Planes cannot land during stormy weather'
      end
    end
  end
end



