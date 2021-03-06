require 'sinatra'
Dir['./lib/*.rb'].each { |file| require file }
require 'sinatra/session'
set :session_secret, 'So0perSeKr3t!'


get "/" do
    @task = Task.new "Eating lunch", "Every one does that", "2006-09-05"
    task_manager.add(@task)
    @tasks = task_manager.tasks
    haml :index
end


get "/new" do
    haml :new
end


post "/new" do
  @task = Task.new params['name'], params['description'], params['date']
  task_manager.add(@task)
  redirect '/'
end


post "/delete" do
  clear_session_and_return_old_taskmager
  @task_manager.delete(params[:name])
  session["task_manager"] = @task_manager
  redirect '/'
end

private

def task_manager
  session_start! unless session?
  session["task_manager"] = TaskManager.new unless session["task_manager"]
  session["task_manager"]
end

def clear_session_and_return_old_taskmager
  @task_manager = session["task_manager"]
  session.clear if session?
  @task_manager 
end
  