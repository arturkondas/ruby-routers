class PostsController < Sinatra::Base

  $posts = [{
    id: 0,
    title: "Post 1",
    body: "This is the first post"
 },
 {
     id: 1,
     title: "Post 2",
     body: "This is the second post"
 },
 {
     id: 2,
     title: "Post 3",
     body: "This is the third post"
 }]

  # Sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), "..")

  # Sets the view directory
  set :views, Proc.new { File.join(root, "views")}

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do

    @title = "Blog posts"

    @posts = $posts

    erb :"posts/index"
  
  end
  
  get '/new'  do

    @post = {
      id: "",
      title: "",
      body: ""
    }
  
    erb :"posts/new"
  
  end
  
  get '/:id' do
  
    id = params[:id].to_i
  
    @post = $posts[id]

    erb :"posts/show"
  
  end
  
  post '/' do
  
    new_post = {
      id: $posts.length,
      title: params[:title],
      body: params[:body]
    }

    $posts.push new_post

    redirect "/"
  
  end
  
  put '/:id'  do
  
    id = params[:id].to_i
    post = $posts[id]

    post[:title] = params[:title]
    post[:body] = params[:body]

    $posts[id] = post

    redirect "/"
  
  end
  
  delete '/:id'  do
  
    id = params[:id].to_i

    $posts.delete_at(id)

    redirect "/"
  
  end
  
  get '/:id/edit'  do
  
    id = params[:id].to_i

    @post = $posts[id]

    erb :"posts/edit"
  
  end

end