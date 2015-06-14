require 'plane'

## Note these are just some guidelines!
## Feel free to write more tests!!

# When we create a new plane, it should be "flying",
# thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should
# be "landed"
#
# When the plane takes off from the airport, it should be "flying" again
#
# Think about your implementation - does it allow a plane to be "flying" and landed?
# Are you testing that?

describe Plane do

  it 'is flying when created' do
  	plane = Plane.new
 		expect(plane).to be_flying
  end

  it 'can land' do 
  	expect(subject).to respond_to :land
  end

  it 'cannot land if already landed' do 
  	subject.land 
  	expect{subject.land}.to raise_error 'Plane has already landed'
  end

  it 'is landed after landing' do 
  	subject.land
  	expect(subject).to be_landed
  end

  it 'can take off' do 
  	expect(subject).to respond_to :take_off
  end

  it 'cannot take off if already flying' do 
  	expect{subject.take_off}.to raise_error 'Plane cannot take off when flying'
  end

  it 'is flying after take off' do 
  	subject.land
  	expect(subject.take_off).to be_flying
  end

  it 'cannot be both flying and landed' do 
  	expect(subject.flying?).not_to eq subject.landed?
  end

end
