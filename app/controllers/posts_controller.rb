class PostsController < ApplicationController
  before_action :set_post, only: %i[ show destroy ]
  before_action :set_draft_post, only: %i[ edit update ]

  # GET /posts or /posts.json
  def index
    @posts = Post.published
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = @post.comments.build
    @cmt_attachment = @comment.build_attachment
    @comments = @post.comments.all
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
    @attachment = @post.build_attachment
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.includes(:likes, comments: :likes).find(params[:id])
      @attachment = @post.attachment
    end

    def set_draft_post
      @post = Post.find_by(id: params[:id], status: 'Draft')
      if @post
        @attachment = @post.attachment || @post.build_attachment
      else
        redirect_to posts_url, alert: "Can't edit published post!"
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :tweet, :status, attachment_attributes: [:id, :attachment, :attachment_cache, :_destroy])
    end
end
