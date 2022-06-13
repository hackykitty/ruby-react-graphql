import * as React from 'react';
import gql from 'graphql-tag';
import { useMutation } from 'react-apollo';
import { QUERY } from '../../posts-show'

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

const DownvotePost = ({ id, viewer }) => {
  const [voteRemove, { loading }] = useMutation(VOTE_REMOVE_MUTATION);

  const voteHandler = () => {
    if (!viewer)
      window.location.href = "/users/sign_in"
    else if (id) {
      const addr = {
        query: QUERY,
        variables: {
          id,
          meta: null
        }
      }
      voteRemove({
        variables: { id },
        update: (cache, { data }) => {
          const queryData = cache.readQuery(addr);
          queryData.post.votesCount--;
          const idx = queryData.post.voters.findIndex(e => e.id === viewer.id)
          queryData.post.voters.splice(idx, 1)
          cache.writeQuery({...addr, data: queryData});
        }
      })
    }
  };

  return (
    <button onClick={voteHandler}>Downvote</button>
  );
};

export default DownvotePost;