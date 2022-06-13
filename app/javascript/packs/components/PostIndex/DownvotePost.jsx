import React, { useState } from 'react';
import gql from 'graphql-tag';
import { useMutation } from 'react-apollo';
import { QUERY } from '../../posts-index'

const VOTE_REMOVE_MUTATION = gql`
  mutation($id: ID!){
    voteRemove(postId: $id) {
      post {
        id
        user {
          id
          image
        }
      }
    }
  }
`

const DownvotePost = ({ post, viewer }) => {
  const [voteRemove, { loading }] = useMutation(VOTE_REMOVE_MUTATION);
  const [votesCount, setVotesCount] = useState(post.votesCount)

  const voteHandler = () => {
    if (!viewer)
      window.location.href = "/users/sign_in"
    else if (post.id) {
      const addr = {
        query: QUERY,
        variables: {
          meta: null
        }
      }
      voteRemove({
        variables: { id: post.id },
        update: (cache, { data }) => {
          const queryData = cache.readQuery(addr);
          const postIdx = queryData.postsAll.findIndex(e => e.id === post.id)
          if (postIdx > -1) {
            queryData.postsAll[postIdx].votesCount--
            const idx = queryData.postsAll[postIdx].voters.findIndex(e => e.id === viewer.id)

            if (idx > -1) {queryData.postsAll[postIdx].voters.splice(idx, 1)}

            cache.writeQuery({ ...addr, data: JSON.parse(JSON.stringify(queryData)) })
            setVotesCount(queryData.postsAll[postIdx].votesCount)
          }
        }
      })
    }
  };

  return (
    <button onClick={voteHandler}>🔽 {votesCount}</button>
  );
};

export default DownvotePost;