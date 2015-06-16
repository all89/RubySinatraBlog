#SESSIONS, LOGIN AND REGISTER.


#Sessions are enabled for each user, with the approprite key, expiration, and secret.
use Rack::Session::Cookie, :key => 'session',
                           :expire_after => 12000, # In seconds
                           :secret => 'blogSinatra2013'


#Register route and erb
get "/register" do
  @title = "Register"
  erb :'users/register'
end


#Each user property from the form is going to be recorded in our Sequel database and a message is going to be shown that all was successful.
#Also regular expressions are implemented to check the validity of each input from the user.
post "/register" do
  string_regex = /\A[A-Z][a-z]+\z/
  usernm_regex = /\A[A-Za-z][\w]{5,11}\z/
  passwd_regex = /\A[\S]{6,15}\z/
  email_regex = /\A[A-Z0-9._-]+@[A-Z0-9.-]+\.[A-Z]{2,6}\z/i
  rfname = params[:name]
  rsname = params[:surname]
  runame = params[:id]
  rpword = params[:password]
  remail = params[:email]
  unamechk = User.where(:id => runame).count
  emailchk = User.where(:email => remail).count
  if (unamechk > 0 || emailchk > 0)
    redirect '/register', :error => 'User already exists. Please choose another username or e-mail.'
  elsif (rfname.empty? || rsname.empty? || runame.empty? || rpword.empty? || remail.empty?)
  redirect '/register', :error => 'Please complete all the fields.'
  elsif ((rfname =~ string_regex) == nil)
  redirect '/register', :error => 'Name field does not contain appropriate characters.'
  elsif ((rsname =~ string_regex) == nil)
  redirect '/register', :error => 'Surname field does not contain appropriate characters.'
  elsif ((runame =~ usernm_regex) == nil)
  redirect '/register', :error => 'Username field does not contain appropriate characters.'
  elsif ((rpword =~ passwd_regex) == nil)
  redirect '/register', :error => 'Password must not contain blank spaces.'
  elsif ((remail =~ email_regex) == nil)
  redirect '/register', :error => 'E-mail field does not contain appropriate characters.'
  else
  User.insert(:id => runame, :password => rpword, :name => rfname, :surname => rsname, :email => remail)
  redirect '/login', :notice => 'Congrats, you are Registered! You can login now.'
  end
end
 
#Login route and erb
get "/login" do
  @title = "Login"
  erb :'users/login'
end

#Logout route, session is closed and the route is redirected.
get "/logout" do
  session.clear
  redirect '/', :notice => 'See you soon!'
end

#The input from the users are going to be validated and if there is a match she/he can be logged in and if not a message is going to appear.
post "/login" do
  log_in = User.where(:id => params[:id], :password => params[:password]).count
  if log_in == 1
    session[:user] = params[:id]
    redirect '/', :notice => 'You are logged in now!'
  else
    redirect '/login', :error => 'Sorry. Your username or password is wrong!'
  end
end