# ``AmiiboService``

Ready-to-use service that retrieves decoded entities from any of the [Amiibo API](https://www.amiiboapi.com) available endpoints.

## Overview

**AmiiboService** provides a service for retrieving data from the remote [Amiibo API](https://www.amiiboapi.com) endpoints that could be used in either in libraries and applications, targeting not only Apple platforms, such as *iOS*, *macOS*, *tvOS*, *watchOS*, and *xrOS*; but *Linux* and *Windows* platforms as well. 

This package provides all the necessary components to the developers to:
* data filtering parameters to the requests to send to the remote service, if required; 
* decoded models from the data coming in from those responses.

## Topics

### Essentials

- <doc:GettingStarted>
- ``AmiiboService/AmiiboService``

### Models

- ``DTO``
- ``DTO/Amiibo``
- ``DTO/KeyName``
- ``DTO/AmiiboSeries``
- ``DTO/AmiiboType``
- ``DTO/Character``
- ``DTO/GameSeries``
- ``DTO/LastUpdated``

### Filters

- ``AmiiboFilter``
- ``KeyNameFilter``
- ``AmiiboSeriesFilter`` 
- ``AmiiboTypeFilter``
- ``CharacterFilter``
- ``GameSeriesFilter``

### Errors

- ``AmiiboClientError``
