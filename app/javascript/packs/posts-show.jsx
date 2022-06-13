import * as React from 'react';
import gql from 'graphql-tag';
import { useQuery } from 'react-apollo';
import renderComponent from './utils/renderComponent';
import UpvotePost from './components/PostShow/UpvotePost'
import DownvotePost from './components/PostShow/DownvotePost'

export const  QUERY = gql`
  query PostsPage($id: ID!) {
    viewer {
      id
      image
    }

    postsAll {
      id
      title
      tagline
      url
      commentsCount
      votesCount
    }

    post(id: $id) {
      id
      description
      title
      tagline
      url
      user {
        id
        name
        image
      }
      makers {
        id
        image
      }
      comments {
        id
        text
        createdAt
        user {
          name
          username
        }
      }
      commenters {
        id
        image
      }
      voters {
        id
        image
      }
      commentsCount
      viewsCount
      votesCount
      dailyFeedPosition
      weeklyFeedPosition
    }
  }
`;

function PostsShow({ postId }) {
  const { data, loading, error } = useQuery(QUERY, {
    variables: {
      id: postId
    }
  });

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;

  const { post, postsAll, viewer } = data;
  const posts = postsAll.filter(e => parseInt(e.id) !== postId)
  posts.splice(3)

  const hasVoted = () => {
    const res = post.voters.filter(e => e.id === viewer.id)
    return res.length > 0;
  }

  return (
    <>
      <div className="box">
        <article className="post">
          <img className="post-image" src={'https://via.placeholder.com/200x200'} />
          <h2 className="post-tagline">
            {post.tagline}
          </h2>
          <div className="post-header flex space-between">
            <h2 className="post-title">
              {post.title}
            </h2>
            {hasVoted() ? <DownvotePost id={postId} viewer={viewer} /> : <UpvotePost id={postId} viewer={viewer} />}

          </div>
          <p className="post-description">{post.description}</p>
          <div className="post-commenters">
            <span className="post-action-user">
              <img className="user-avatar" src={post.user.image} />
              <img className="post-action-tag" src="/assets/hunter.svg" />
            </span>
            {post.makers.map(c => (
              <span className="post-action-user" key={`maker-${c.id}`}>
                <img className="user-avatar" src={c.image} />
                <img className="post-action-tag" src="/assets/maker.svg" />
              </span>
            ))}
            {post.commenters.map(c => (
              <span className="post-action-user" key={`commenter-${c.id}`}>
                <img className="user-avatar" src={c.image} />
                <img className="post-action-tag" src="/assets/commenter.svg" />
              </span>
            ))}
            {post.voters.map(c => (
              <span className="post-action-user" key={`voter-${c.id}`}>
                <img className="user-avatar" src={c.image} />
                <img className="post-action-tag" src="/assets/upvoter.svg" />
              </span>
            ))}
          </div>
          <div className="post-action flex space-between">
            <div className="flex align-items-center">
              <img className="user-avatar" src={'https://via.placeholder.com/200x200'} />
              <span className="post-action__input">What do you think?</span>
            </div>
            <button className="post-action__btn">Comment</button>
          </div>
          <div className="post-comment">
            {post.comments.map(c => (
              <div className="post-comment--content" key={`comment-${c.id}`}>
                <div className="flex align-items-center post-comment__user">
                  <img className="user-avatar" src={c.user.image || 'https://via.placeholder.com/200x200'} />
                  <span className="post-comment__user--name">{c.user.name}</span>
                  <span className="post-comment__user--username">@{c.user.username}</span>
                </div>
                <p className="post-comment__text">
                  {c.text}
                </p>
                <div className="post-comment__date">{c.createdAt}</div>
              </div>
            ))}
          </div>
          <div className="post-about">
            <div className="post-about__title">
              <h3>About this post</h3>
            </div>
            <div className="post-about__content">
              <div className="flex space-between">
                <div className="post-statistics-item">
                  <div className="post-statistics-item__title">Upvotes</div>
                  <div className="post-statistics-item__content">{post.votesCount}</div>
                </div>
                <div className="post-statistics-item">
                  <div className="post-statistics-item__title">Comments</div>
                  <div className="post-statistics-item__content">{post.commentsCount}</div>
                </div>
                <div className="post-statistics-item">
                  <div className="post-statistics-item__title">Views</div>
                  <div className="post-statistics-item__content">{post.viewsCount}</div>
                </div>
                <div className="post-statistics-item">
                  <div className="post-statistics-item__title">Daily rank</div>
                  <div className="post-statistics-item__content">#{post.dailyFeedPosition}</div>
                </div>
                <div className="post-statistics-item">
                  <div className="post-statistics-item__title">Weekly rank</div>
                  <div className="post-statistics-item__content">#{post.weeklyFeedPosition}</div>
                </div>
              </div>
            </div>
            <div className="post-about__report">
              <span>Report</span>
              <span>&#183;</span>
              <span>Edit this page</span>
            </div>
          </div>
          <div className="post-trending">
            <div className="post-trending__title">
              <div className="horizon-bar"></div>
              <h3>Trednding posts</h3>
              <div className="horizon-bar"></div>
            </div>
            <div className="post-trending__content">
              <div className="flex space-between">
                {posts.map(c => (
                  <div className="post-trending-item" key={`post-trending-${c.id}`}>
                    <img className="post-trending-item__image" src={'https://via.placeholder.com/200x200'} />
                    <div className="post-trending-item__title">{c.title}</div>
                    <div className="post-trending-item__description">{c.tagline}</div>
                    <div className="post-trending-item__content">
                      <span>&#x25B2; {c.votesCount}</span>
                      <span className="mx-2">&#183;</span>
                      <span>{c.commentsCount} comments</span>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </article>
      </div>
    </>
  );
}

// renderComponent(graphql(QUERY, { options: { pollInterval: 5000 } })(PostsShow));

renderComponent(PostsShow);
