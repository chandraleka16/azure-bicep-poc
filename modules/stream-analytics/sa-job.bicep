// Stream Analytics Job Template

param streamAnalyticsJobName string
param location string
param jobTransformationName string
param streamingUnits int
param validStreamingUnits int

resource streamAnalyticsJob 'Microsoft.StreamAnalytics/streamingjobs@2020-03-01' = {
  name: streamAnalyticsJobName
  location: location
  properties: {
    transformation: {
      name: jobTransformationName
      properties: {
        streamingUnits: streamingUnits
        validStreamingUnits: [
          validStreamingUnits
        ]
      }
    }
  }
}
