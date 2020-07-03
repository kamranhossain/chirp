defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component

  def render(assigns) do
    ~L"""
      <div id="post-<%= @post.id %>" class="post">
        <div class="row">
          <div class="column column-10">
            <div class="post-avatar">
              <img src="https://via.placeholder.com/100" alt="<%= @post.username %>">
            </div>
          </div>
          <div class="column column-90 post-body">
            <span class="user_name">@<%= @post.username %></span>
            <br>
            <p><%= @post.body %></p>
          </div>
        </div>

        <div class="row actions_bar">
          <div class="column">
            <i class="far fa-heart"></i> <%= @post.likes_count %>
          </div>
          <div class="column">
            <i class="fa fa-retweet"></i> <%= @post.reposts_count %>
          </div>
          <div class="column">
            <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
              <i class="far fa-edit"></i>
            <% end %>
            <%= link to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] do %>
              <i class="far fa-trash-alt"></i>
            <% end %>
          </div>
        </div>
      </div>
    """
  end

  def handle_event("like", _, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
