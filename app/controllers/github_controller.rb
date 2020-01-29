class GithubController < ApplicationController
  def callback
    response = Github.get_access_token(params[:code])

    client = Octokit::Client.new(:access_token => response["access_token"])
    github_user = client.user

    user = User.find_or_initialize_by(github_id: github_user.id)
    user.name = github_user.name
    user.email = github_user.email
    user.avatar_url = github_user.avatar_url
    user.profile_url = github_user.html_url
    user.save

    cookies[:current_user_id] = {
      :value => user.id,
      :expires => 30.days.from_now
    }

    redirect_to root_path
  end
end
