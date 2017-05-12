require "rspec"

require_relative "list"
require_relative "task"

describe List do
  let(:title)	{ "Apple The Dog"}
  let(:tasks) { [Task.new("Hello"), Task.new("World"), Task.new("Sleep"), Task.new("Eat")] }
  let(:list)	{ List.new(title,tasks) }

  describe "#initialize" do
  	it "takes a title for its first argument" do 
  		expect(List.new("Apple The Dog")).to be_a_kind_of(List)
  	end

  	it "requires one argument" do
  		expect { List.new }.to raise_error(ArgumentError)
  	end
  end

  describe "#title" do
	  it "returns the correct title for the list" do
	  	expect(list.title).to eq title
	  end
	end

	describe "#task" do
		it "returns the correct task for the list" do
			expect(list.tasks).to eq tasks
		end
	end

	describe "#add_task" do
		# task present, add new task to list
		it "appends a new task to the list" do
			test_task = Task.new("Feed the dog")
			expect {list.add_task(test_task)}.to change{list.tasks.count}.by(1)
		end

		# task empty, raise error
		it "must accept a task to proceed" do
			expect { list.add_task }.to raise_error(ArgumentError)
		end
	end

	describe '#complete_task' do
		it "change the status from incomplete to complete" do
			expect {list.complete_task(0)}.to change{list.tasks[0].complete?}.from(false).to(true)
		end

		it "requires an index to proceed" do
  		expect { list.complete_task() }.to raise_error(ArgumentError)
  	end

  	it "requires a valid index to proceed" do
  		expect(list.tasks[100]).nil?
  	end
	end

	describe '#delete_task' do
		it "removes a specific task from the list" do
			deleted_task = list.tasks[1]
			expect(list.delete_task(1)).to eq deleted_task
		end

		it "requires an index to proceed" do
  		expect { list.delete_task() }.to raise_error(ArgumentError)
  	end

  	it "requires a valid index to proceed" do
  		expect(list.delete_task(100)).nil?
  	end
	end

	describe '#completed_tasks' do
		it "selects only task that is completed" do
			list.complete_task(0)
			list.complete_task(1)
			expect(list.completed_tasks).to eq([list.tasks[0], list.tasks[1]])
		end
	end

	describe '#incompleted_tasks' do
		it "excludes task that is completed" do
			list.complete_task(0)
			list.complete_task(1)
			expect(list.incomplete_tasks).not_to eq([list.tasks[0], list.tasks[1]])
		end
	end
end











