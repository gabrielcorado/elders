# Include the helper
require 'spec_helper'

# Tests
describe 'Task' do
  # Time to complete the task
  let(:time) { 0.1 }

  # Create the task before the tests
  before(:all) do
    @task = Elders::Task.new 'test-task', 'busybox', 'printenv'
  end

  # Delete the task
  after(:all) do
    @task.clean
  end

  it 'should be created' do
    # Assertions
    expect(@task.name).to eq('test-task')
    expect(@task.command).to eq('printenv')
  end

  it 'should be started' do
    # Start it
    @task.start nil, ['APP_ENV=test']

    # Wait for it run
    sleep time

    # Assertions
    expect(@task.container).to be_a(Docker::Container)
    expect(@task.completed?).to eq(true)
    expect(@task.success?).to eq(true)
    expect(@task.promise.state).to eq(:fulfilled)
    expect(@task.logs.size).to be > 1
    expect(@task.logs).to match(/APP_ENV/)
  end

  it 'should be deleted' do
    # Start the task
    @task.start

    # Wait for the task
    sleep time

    # Delete it
    @task.delete

    # Container
    expect { @task.container }.to raise_error
  end
end
