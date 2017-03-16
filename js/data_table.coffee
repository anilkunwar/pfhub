---
---

fname = (data, type, row) ->
  '<a href="{{ site.links.simmeta }}/' + data + '/meta.yaml" target="_blank">' + data + '</a>'

fauthor = (data, type, row) ->
  if data.email
    '<a href="mailto:' + data.email + '">' + data.name + '</a>'
  else
    data.name

fcode = (data, type, row) ->
  if data.url
    '<a href="' + data.url + '" target="_blank">' + data.name + '</a>'
  else
    data.name


d3_func = (yaml_text) ->
  data_raw = jsyaml.load(yaml_text)['data']

  data_filter = (datum for datum in data_raw when datum['id_'] is benchmark_id)

  data_table = if benchmark_id is '' then data_raw else data_filter

  data = {
    lengthMenu: [15]
    lengthChange: false
    data: data_table
    columns: [
      {
        data: "name"
        title: "Name"
        render: fname
      }
      {
        data: "code"
        title: "Code"
        render: fcode
      }
      {
        data: "id_"
        title: "Benchmark"
      }
      {
        data: "author"
        title: "Author"
        render: fauthor
      }
      {
        data: "timestamp"
        title: "Timestamp"
      }
      {
        data: "cores"
        title: "Cores"
      }
    ]
  }

  func = () ->
    $("#data_table").DataTable data

  $(document).ready func

d3.text("{{ site.baseurl }}/data/data_table.yaml", d3_func)
