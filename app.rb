# ======= requires =======
require "sinatra"
# require "sinatra/reloader"
require 'sinatra/activerecord'


# ======= models =======
require './models'


# ======= database =======
configure(:developemnt){
	set :database, "sqlite3:newblog.db"
}

# ======= sessions =======
enable :sessions

# ======= home =======
get '/' do
	erb :login
end

post '/sign_in' do
	puts "\n******* sign_in *******"
	@user = User.where(username: params[:username]).first
	if @user.password == params[:password]
		session[:user_id] = @user.id
		puts "session[:user_id]: #{session[:user_id]}"
		puts "@user.id: #{@user.id}"
		redirect '/home'
	else
		redirect "/"
	end
end

get '/home' do
	puts "\n******* home *******"
	puts "session[:user_id]: #{session[:user_id]}"
	@posts = Post.all
	erb :home
end

get '/new_user' do
	puts "\n******* new_user *******"
	erb :make_new_user
end

post '/sign_up' do
	puts "\n******* sign_up *******"
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
	@user = User.order("created_at").last
	redirect '/home'
end

get '/all_user' do
	puts "\n******* all_user *******"
	puts "session[:user_id]: #{session[:user_id]}"
	@users = User.all
	puts "@users.inspect: #{@users.inspect}"
	erb :all_user
end

get '/update/:id' do
	puts "\n******* update *******"
	puts "params.inspect: #{params.inspect}"
	@user = User.find params[:id]
	erb :update
end

get '/profile/:id' do
	puts "\n******* profile *******"
	puts "session[:user_id]: #{session[:user_id]}"
	@user = User.find params[:id]
	erb :profile
end

post '/update' do
	puts "\n******* update *******"
	puts "params.inspect: #{params.inspect}"
	@user = User.find params[:id]
	User.find(params[:id]).update_attributes(params)
	erb :profile
end

get '/delete/:id' do
	puts "\n******* delete *******"
	puts "params.inspect: #{params.inspect}"
	# @user = User.find params[:id]
	User.find(params[:id]).destroy
	redirect '/all_user'
end

get '/new_post' do
	puts "\n******* new_post *******"
	puts "session[:user_id]: #{session[:user_id]}"
	@user = User.find session[:user_id]
	erb :new_post
end

post '/create_post' do
	puts "\n******* create_post *******"
	@user = User.find session[:user_id]
	Post.create(
		user_id: params[:user_id],
		title: params[:title],
		content: params[:content],
	)
	redirect '/home'
end
