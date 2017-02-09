# ======= requires =======
require "sinatra"
# require "sinatra/reloader"
require 'sinatra/activerecord'

# ======= models =======
require './models'

set :database, "sqlite3:newblog.db"

# ======= sessions =======
# set :sessions, true

# ======= home =======
get '/' do
	erb :home
end

get '/home' do
	erb :home
end

get '/new_user' do
	erb :make_new_user
end

post '/sign_up' do
	puts "\n******* new_user *******"
	puts "params.inspect: #{params.inspect}"
	User.create(
		username: params[:username],
		password: params[:password],
	  firstname: params[:firstname],
	  lastname: params[:lastname],
	  usertype: params[:usertype],
		rating: params[:rating],
	  email: params[:email]
	)
	puts @user
	@user = User.order("created_at").last
	redirect '/'
end

get '/all_user' do
	@users = User.all
	puts "@users.inspect: #{@users.inspect}"
	erb :all_user
end

get '/update/:id' do
	puts "params.inspect: #{params.inspect}"
	@user = User.find params[:id]
	erb :update
end

get '/profile/:id' do
	@user = User.find params[:id]
	erb :profile
end

post '/update' do
	puts "params.inspect: #{params.inspect}"
	@user = User.find params[:id]
	User.find(params[:id]).update_attributes(params)
	erb :profile
end

get '/delete/:id' do
	puts "params.inspect: #{params.inspect}"
	# @user = User.find params[:id]
	User.find(params[:id]).destroy
	redirect '/all_user'
end
