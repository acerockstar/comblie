# API Reference

Network | Webhooks | Feed? | Chat? | Notifications?
------- | ---------| ----- | ----- | ------fo--------
[Facebook](https://developers.facebook.com/docs/graph-api)  | [Real-Time Updates](https://developers.facebook.com/docs/graph-api/real-time-updates/v2.4) | Y | Y | Y
[Twitter](https://dev.twitter.com/overview/documentation)   | [Streaming](https://dev.twitter.com/streaming/overview) | Y | Y | Y
[Instagram](https://instagram.com/developer/)               | [Real-Time Updates](https://instagram.com/developer/realtime/) | Y | N | Y
[Vine](https://github.com/starlock/vino/wiki/API-Reference) | N/A: Polls | Y | N | Y
[Tumblr](https://www.tumblr.com/docs/en/api/v2)             | N/A: Polls | Y | Y | Y

# Authentication

1. Client authenticates with a social network provider, yielding an **access token**.
2. Client encypts the access tokens (using the Comblie app secret as the key) and sends the encrypted values to the server.
3. Server decrypts the access tokens and uses them to fetch data on behalf of the user from the corresponding social network provider.
4. Access tokens for all social networks are stored on the client (encrypted) with their expiration dates. Each time the client is launched, the client does what is necessary to extend the expiration dates of the access tokens. When unsuccessful, the client obtains prompts the user to reauthenticate, yielding a new access token.

The `meta` property of the request object contains these encrypted access tokens:

```
{
  "meta": {
    "access_tokens": {
      "facebook": "",
      "twitter": "",
      "instagram": "",
      "vine": "",
      "tumblr": ""
    },
    ...
  }
}
```

# Loading Data

## Feed/Messages/Notifications

### Initial Load

Client requests initial data (one time per session) with a GET request.

This represents the R in CRUD (Read).

The response includes data aggragated from all social networks.

#### Methods

`/feed`

```
{
  "meta": {
    "code": 200,
    ...
  },
  "response": { ... }
}
```

----

`/messages`

```
{
  "meta": {
    "code": 200,
    ...
  },
  "response": { ... }
}
```

----

`/notifications`

```
{
  "meta": {
    "code": 200,
    ...
  },
  "response": { ... }
}
```

### Scroll

After initial load, the user may scroll to see more data in feed/messages/notifications.

Note that the feed and notifications have the same sort order (most recent to the top), while messages have the opposite sort order (most recent to the bottom).

When the scroll to load more data happens, the client issues a GET request to the server requesting the next page(s) of data.

#### Methods

`/scroll/feed`

```
{
  "meta": {
    "code": 200,
    ...
  },
  "response": { ... }
}
```

This behaves similarly to the initial GET of feed posts.

The response includes data from all social networks.

----

`/scroll/messages`

```
{
  "meta": {
    "code": 200,
    ...
  },
  "response": { ... }
}
```

While the initial GET returns a list of threads, this method returns a list of messages for a given thread.

The response includes data for the provided thread.

----

`/scroll/notifications`

```
{
  "meta": {
	"code": 200,
	...
  },
  "response": { ... }
}
```

This behaves similarly to the initial GET of notifications.

The response includes data from all social networks.

### Real-Time Updates

After initial load, the client subscribes to methods on the server using [EventSource](https://github.com/neilco/EventSource). The server then pushes real-time updates to the client, and the client responds by redrawing the UI as appropriate.

*TODO: Determine how to push notifications to a specific user (instead of broadcasting to all subscribers of an endpoint).*

These represent the C, U, and D in CRUD (Create/Update/Delete).

Currently, only Facebook, Twitter, and Instagram provide real-time updates. Vine and Tumblr require the server to poll every 15 seconds for new data.

#### Payloads

`/updates/feed`

```
{
  "meta": {
    "code": 200,
    "type": "C/U/D"
  },
  "data": {
    ...
  }
}
```

----

`/updates/messages`

```
{
  "meta": {
    "code": 200,
    "type": "C/U/D"
  },
  "data": {
    ...
  }
}
```

----

`/updates/notifications`

```
{
  "meta": {
    "code": 200,
    "type": "C/U/D"
  },
  "data": {
    ...
  }
}
```

# POSTing Data

## Feed

The user can do one of the following:

Action        | Supported Networks
------------- | -------------------
Post Text     | Facebook, Twitter, Tumblr
Post Photo    | Facebook, Twitter, Instagram, Vimeo, Tumblr
Post Video    | Facebook, Twitter, Instagram, Vimeo, Tumblr
Post Location | Facebook, Twitter
Like Post     | Facebook, Instagram, Vimeo, Tumblr
Favorite Post | Twitter

When posting, combinations are allowed as long as an element of the post (text/photo/video/location) is guaranteed to be posted somewhere based on the table above.

For example, the Tumblr option is disabled if the user is interested in only posting a location; however, if the user also adds text, the Tumblr option is enabled. The server ultimately decides where the payload can be posted.

When the post is submitted, the client POSTs to:

`/feed`

Request:

```
{
    "meta": {
        ...
    },
    "data": {
        ...
    }
}
```

Response:

```
{
    "meta": {
        ...
    },
    "data": {
        "code": 200,
        ...
    }
}
```

Assisted tagging (e.g. when "@" or "#" is typed) is not included in the first iteration of the app.

## Messages

Users can only respond to existing messages. They cannot start a conversation or modify the participants of a conversation.

When this happens, the client POSTs to:

`/messages`

Request:

```
{
    "meta": {
        ...
    },
    "data": {
        ...
    }
}
```

Response:

```
{
    "meta": {
        ...
    },
    "data": {
        "code": 200,
        ...
    }
}
```

The first iteration of the app lacks certain popular features such as "..." to indicate a recipient is typing or read reciepts. 

## Notifications

Notifications are read-only.
