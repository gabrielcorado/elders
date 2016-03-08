# Include the helper
require 'spec_helper'

# Tests
describe 'Stack' do
  # Time to complete the task
  let(:time) { 3 }

  # Create the task before the tests
  before(:all) do
    # Commands list
    @tasks = ['sleep 2', 'ls', 'ls /bin'].map do |command|
      # Generate a task for this command
      Elders::Task.new("#{command[0..1]}-task", 'busybox', command)
    end

    # Generate the stack
    @stack = Elders::Stack.new @tasks
  end

  # Delete the task
  after(:all) do
    @stack.clean
  end

  it 'should be created' do
    # Assertions
    expect(@stack.tasks[0]).to eq(@tasks[0])
    expect(@stack.tasks[1]).to eq(@tasks[1])
    expect(@stack.tasks[2]).to eq(@tasks[2])
  end

  it 'should be started' do
    # Start it
    @stack.start

    # Wait for it run
    @stack.wait

    # Assertions
    expect(@stack.promise.state).to be(:fulfilled)
    expect(@stack.tasks[0].completed?).to eq(true)
    expect(@stack.tasks[1].completed?).to eq(true)
    expect(@stack.tasks[2].completed?).to eq(true)
  end
end
