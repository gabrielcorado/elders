#
class Elders::Task
  # Task timeout
  TIMEOUT = 1500

  # Attributes
  attr_reader :name, :command, :promise

  # Creates a new task, but not start it
  # @param {String} name - Task name
  # @param {String} image - Docker image that the command
  #                         is going to be runned on.
  # @param {String} command - The `bash` command that is
  #                           going to be runned.
  def initialize(name, image, command)
    # Define the values
    @name = name
    @image_name = image
    @command = command
  end

  # Start the task
  # Shellwords.escape
  # @param {String} params - Params for the task/command
  def start(params = nil, env = nil)
    # Clean
    clean

    # Add params to the command
    command = @command
    command = "#{command} #{params}" unless params.nil?

    # Create the container
    @container = Docker::Container.create 'Image' => @image_name, 'Cmd' => Shellwords.split(command), 'Env' => env

    # Start it
    @container.start

    # Wait for the container to end
    @promise = Concurrent::Promise.execute { @container.wait }
  end

  # Stop the task
  def stop
    container.stop
  end

  # Task logs
  def logs
    container.logs stdout: true
  end

  # Delete the container
  def delete
    # Delete the containe
    res = container.delete force: true

    # Clean it
    @container = nil if res == nil

    # Return the result
    res
  end

  # Clean the task
  def clean
    # There is nothing to clean
    return true unless container?

    # Delete the container
    delete == nil
  end

  # Get the task container
  def container
    # Check if @container exists
    raise 'Task was not started' unless container?

    # Return the container
    @container
  end

  # Check if the container exists
  def container?
    !@container.nil?
  end

  # Error in running the task?
  def error?
    # Check if the task is completed
    return nil unless completed?

    # Check the task status code
    @promise.value['StatusCode'] > 0
  end

  # Completed the task?
  def completed?
    @promise.fulfilled?
  end

  # Check if the task was a success
  def success?
    completed? && !error?
  end
end
