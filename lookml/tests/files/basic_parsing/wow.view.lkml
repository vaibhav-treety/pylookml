explore: custom_audience_revenue {
  sql_preamble:
  CREATE TEMP FUNCTION
    get_negative_segments(json STRING)
    RETURNS ARRAY<STRING>
    LANGUAGE js AS """
      if (json ===null){
          return []
      }
      return (
          JSON.parse(json)
              .filter(obj => obj.operation === 'EXCLUDE')
              .map(obj => obj.segment_id)
              .reduce((prev,curr) => prev.concat(curr),[])
              .filter(x => !!x)
      )
  """;

  CREATE TEMP FUNCTION
    get_positive_segments(json STRING)
    RETURNS ARRAY<STRING>
    LANGUAGE js AS """
      if (json ===null){
          return []
      }
      return (
          JSON.parse(json)
              .filter(obj => obj.operation !== 'EXCLUDE')
              .map(obj => obj.segment_id)
              .reduce((prev,curr) => prev.concat(curr),[])
              .filter(x => !!x)
      )
  """;
    ;;
}