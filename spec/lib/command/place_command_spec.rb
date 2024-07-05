describe UnitRobot::Command::PlaceCommand do
  it "should return the parsed position if valid" do
    command = UnitRobot::Command::PlaceCommand.new('PLACE 2,2,NORTH', nil)

    command.process

    expect(command.final_position).to eq({ x: 2, y: 2, direction: 'NORTH' })
  end

  it "should return final position as nil if invalid" do
    command = UnitRobot::Command::PlaceCommand.new('PLACE 2,2,NOxRTH', nil)

    command.process

    expect(command.final_position).to be_nil
  end
end
