Sequel.migration do
	users = DB[:users]
	posts = DB[:posts]
	tags = DB[:tags]
	post_tag = DB[:Posts_Tags]


  	up do	
  		users.insert(:id => "sjobs", :password => "123456", :name => "Steve", :surname => "Jobs", :email => "sjobs@apple.com")
		users.insert(:id => "bgates", :password => "123456", :name => "Bill", :surname => "Gates", :email => "bgates@hotmail.com")

		posts.insert(:title => "Hands on: Sony PS4 review", :content => "The PlayStation 4 is here, but as of this writing, PSN servers have yet to go online. We're currently putting the system through our rigorous review process, and will report back when we have the whole the story. Until then, enjoy our updated hands on and keep checking back for our full PS4 review.<br> The battle for the living room is a cold war no more. Sony's PlayStation 4 is ready to go thermonuclear, hitting North American retailers on November 15, and marching onto UK shelves November 29.<br> Housing some of the most powerful hardware ever to sit before a television, Sony's new console is two sleek slabs of industrial design fused together for one purpose: living room dominance.",:created_at => DateTime.now, :user_id => "sjobs", :view_count => 0)
		posts.insert(:title => "OS X 10.9 Mavericks review", :content => "The tenth major revision of OS X, Mavericks, marks an attempt at a fresh start.<br> Oh yeah, and it's available as a free download! Apple has decided it should treat the Mac community in the same way it has been treating iOS users and ship the update free via the Mac App Store.<br> Mavericks introduces new features that are aimed at professionals, updates major interface components, it overhauls the system's branding. Big cats are out, and California locations are in (Mavericks being a surfing hotspot).",:created_at => DateTime.now, :user_id => "bgates", :view_count => 0)
		posts.insert(:title => "An Introduction to Haml and Sinatra", :content => "This tutorial will introduce Haml and Sinatra. Haml is a markup language that produces clean, well-structured HTML. Sinatra is a simple but powerful Ruby framework for creating websites or web services. The two work very well together and provide a powerful tool for quick and simple web development. I find them ideal for prototyping.<br> By the end of this tutorial, you will have created a website with two pages using Sinatra and Haml. Along the way, you’ll learn how Sinatra applications are structured, and will be introduced to Haml. You will also learn how to use a layout file to reduce the amount of duplicated code and give consistency between the pages.",:created_at => DateTime.now, :user_id => "bgates", :view_count => 0)
		posts.insert(:title => "Why You Should Use RVM", :content => "RVM stands for Ruby enVironment Manager. Here’s the idea. As a Ruby developer, you might run into situations where you’d need to use multiple versions of Ruby. For example, you started with Ruby 1.8.6, but now you want to experiment with 1.9.2. Or, you normally work with the 1.9 branch, but you want to contribute to an open source project that’s still on the 1.8 branch.<br> Without RVM, it’s pretty difficult to have more than one version of Ruby on your computer. Or, what if you want to try one of the alternate Ruby interpreters, like Rubinius or JRuby? How can you take one out for a spin without giving up your faithful MRI install? This is where RVM steps in. It’s basically a framework that handles multiple installations of Ruby for you, and makes it easy for you to switch between them.",:created_at => DateTime.now, :user_id => "sjobs", :view_count => 0)
		posts.insert(:title => "Ruby for Newbies: Working with Gems", :content => "Ruby is a one of the most popular languages used on the web. We’ve started a new Session here on Nettuts+ that will introduce you to Ruby, as well as the great frameworks and tools that go along with Ruby development. Today, we’ll look at the awesome packaging system that Ruby provides for distributing programs and libraries: Gems.<br> It’s pretty simple, really. You can think of a Ruby Gem as a library or plug-in. It’s some functionality that you’ll install to fill a specific need.",:created_at => DateTime.now, :user_id => "sjobs", :view_count => 0)
		
		tags.insert(:name => "ruby")
		tags.insert(:name => "sinatra")
		tags.insert(:name => "sony")
		tags.insert(:name => "mavericks")
		tags.insert(:name => "rvm")
		tags.insert(:name => "os")
		tags.insert(:name => "ps4")
		tags.insert(:name => "haml")
		tags.insert(:name => "gems")

		post_tag.insert(:post_id => 1, :tag_id => 3)
		post_tag.insert(:post_id => 1, :tag_id => 7)
		post_tag.insert(:post_id => 2, :tag_id => 4)
		post_tag.insert(:post_id => 2, :tag_id => 6)
		post_tag.insert(:post_id => 3, :tag_id => 8)
		post_tag.insert(:post_id => 3, :tag_id => 2)
		post_tag.insert(:post_id => 4, :tag_id => 5)
		post_tag.insert(:post_id => 5, :tag_id => 1)
		post_tag.insert(:post_id => 5, :tag_id => 9)
		post_tag.insert(:post_id => 1, :tag_id => 6)
		post_tag.insert(:post_id => 5, :tag_id => 8)
	end

	down do
		drop users
		drop posts
		drop tags
		drop post_tag
	end
end