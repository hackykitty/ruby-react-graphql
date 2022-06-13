import * as React from 'react';
import ReactDOM from 'react-dom';
import createApolloClient from './createApolloClient';
import { ApolloProvider } from 'react-apollo';

export default function renderComponent(Component) {
  const client = createApolloClient();
  const dom = document.getElementById('react-app');
  const props = dom.dataset.props ? JSON.parse(dom.dataset.props) : {}

  document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
      <ApolloProvider client={client}>
        <Component {...props} />
      </ApolloProvider>,
      dom,
    );
  });
}
