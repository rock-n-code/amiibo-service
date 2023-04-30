# ``AmiiboService``

Ready-to-use service that retrieves decoded entities from any of the [Amiibo API](https://www.amiiboapi.com) available endpoints.

## Overview

**AmiiboService** provides a service, filters and models for retrieving data from the remote [Amiibo API](https://www.amiiboapi.com) endpoints to use in libraries and applications targeting not only Apple platforms, such as *iOS*, *macOS*, *tvOS*, and *watchOS*, but also *Linux*. This package provides structures that can be used to include filters to the requests to send to the remote service if required. In addition, the structures to model the kinds of data coming in from those responses into entities are also provided.

## Topics

### Essentials

- <doc:GettingStarted>
- ``AmiiboService/AmiiboService``

### Filter data when making requests

- ``AmiiboFilter``
- ``KeyNameFilter``
- ``AmiiboSeriesFilter`` 
- ``AmiiboTypeFilter``
- ``CharacterFilter``
- ``GameSeriesFilter``

### Models to decode the data coming from the responses

- ``Amiibo``
- ``KeyName``
- ``AmiiboSeries``
- ``AmiiboType``
- ``Character``
- ``GameSeries``
- ``LastUpdated``

### Errors that can be thrown by the service

- ``AmiiboClientError``
