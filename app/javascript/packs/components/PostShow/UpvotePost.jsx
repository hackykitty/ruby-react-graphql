import * as React from 'react';
import gql from 'graphql-tag';
import { useMutation } from 'react-apollo';
import { QUERY } from '../../posts-show'

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

const UpvotePost = ({ id, viewer }) => {
  const [voteAdd, { loading }] = useMutation(VOTE_ADD_MUTATION);

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
      voteAdd({
        variables: { id },
        update: (cache, { data }) => {
          const queryData = cache.readQuery(addr);
          queryData.post.votesCount++;
          queryData.post.voters.push(viewer)
          cache.writeQuery({...addr, data: queryData});
        }
      })
    }
  };

  return (
    <button onClick={voteHandler}>Upvote</button>
  );
};

export default UpvotePost;