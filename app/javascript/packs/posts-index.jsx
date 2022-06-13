import * as React from 'react';
import gql from 'graphql-tag';
import { useQuery } from 'react-apollo';
import renderComponent from './utils/renderComponent';
import UpvotePost from './components/PostIndex/UpvotePost'
import DownvotePost from './components/PostIndex/DownvotePost'

export const QUERY = gql`
  query PostsPage {
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
      voters {
        id
        image
      }
    }
  }
`;

function PostsIndex() {
  const { data, loading, error } = useQuery(QUERY)

  if (loading) return 'Loading...'
  if (error) return `Error! ${error.message}`

  const hasVoted = (post) => {
    const res = post.voters.filter(e => e.id === data.viewer.id)
    return res.length > 0
  }

  return (
    <div className="box">
      {data.postsAll.map((post) => (
        <article className="post" key={`post-${post.id}`}>
          <h2>
            <a href={`/posts/${post.id}`}>{post.title}</a>
          </h2>
          <div className="url">
            <a href={post.url}>{post.url}</a>
          </div>
          <div className="tagline">{post.tagline}</div>
          <footer>
            {hasVoted(post) ? <DownvotePost post={post} viewer={data.viewer} /> : <UpvotePost post={post} viewer={data.viewer} />}
            <button>💬 {post.commentsCount}</button>
            {hasVoted(post) && <span>You voted</span>}
          </footer>
        </article>
      ))}
    </div>
  )
}

renderComponent(PostsIndex)
