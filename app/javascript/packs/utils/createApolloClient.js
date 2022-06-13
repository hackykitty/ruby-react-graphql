import { ApolloClient } from 'apollo-client';
import { createHttpLink } from 'apollo-link-http';
import { InMemoryCache } from 'apollo-cache-inmemory';

export default function createApolloClient() {
  const metaTag = document.querySelector('meta[name=csrf-token]');
  const csrfToken = metaTag ? metaTag.getAttribute('content') : null;

  return new ApolloClient({
    link: createHttpLink({
      uri: '/graphql',
      credentials: 'same-origin',
      headers: {
        'X-CSRF-Token': csrfToken,
      },
    }),
    cache: new InMemoryCache(),
  });
}
