#
module Elders
  #
  class Stack
    # Attributes
    attr_reader :tasks
    attr_accessor :promise

    # Create a new the stack
    # @param {Array<Task>} tasks - The tasks from the stack
    def initialize(tasks)
      # Set tasks
      @tasks = tasks
    end

    # Start
    # @param {String} params - Params used by all the tasks
    def start(params = nil)
      # Start the tasks and get it promises
      promises = @tasks.map do |task|
        # Start the task
        task.start params

        # Get the promise
        task.promise
      end

      # Wait for all the tasks
      @promise = Concurrent::Promise.all? *promises

      # Execute the promises
      @promise.execute
    end

    # Clean all the stack tasks
    def clean
      # Each the tasks
      @tasks.each do |task|
        # Clean all of them
        task.clean
      end
    end

    # Wait until all the promises to finish
    # @param {Integer} limit - Limit of waiting in seconds
    def wait(limit = nil)
      # Define the timeout
      timeout = Time.now.to_i + limit unless limit.nil?

      # Success?
      success = false

      # Inifiny loop
      loop do
        # Timeout?
        break if !timeout.nil? && Time.now.to_i >= timeout

        # Set the success
        success = @promise.fulfilled?

        # Completed?
        break if success
      end

      # Return the success
      success
    end
  end
end
