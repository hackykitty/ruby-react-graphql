import React, { useState } from 'react';
import gql from 'graphql-tag';
import { useMutation } from 'react-apollo';
import { QUERY } from '../../posts-index'

const VOTE_ADD_MUTATION = gql`
  mutation($id: ID!){
    voteAdd(postId: $id) {
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

const UpvotePost = ({ post, viewer }) => {
  const [voteAdd, { loading }] = useMutation(VOTE_ADD_MUTATION);
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
      voteAdd({
        variables: { id: post.id },
        update: (cache, { data }) => {
          const queryData = cache.readQuery(addr);
          const idx = queryData.postsAll.findIndex(e => e.id === post.id)
          
          if (idx > -1) {
            queryData.postsAll[idx].votesCount++;
            queryData.postsAll[idx].voters.push(viewer)
            cache.writeQuery({ ...addr, data: JSON.parse(JSON.stringify(queryData)) });
            setVotesCount(queryData.postsAll[idx].votesCount)
          }
        }
      })
    }
  };

  return (
    <button onClick={voteHandler}>🔼 {votesCount}</button>
  );
};

export default UpvotePost;