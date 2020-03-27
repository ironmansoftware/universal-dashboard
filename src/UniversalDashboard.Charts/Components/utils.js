
export const generateCsvString = data => {
  const csvRows = []

  // create csv headers
  const headers = Object.keys(data[0])
  csvRows.push(headers.join(','))

  // loop over the rows
  for (const row of data) {
    const values = headers.map(header => {
      const escaped = ('' + row[header]).replace(/"/g, '\\"')
      return `"${escaped}"`
    })
    csvRows.push(values.join(','))
  }

  // return the correct data
  return csvRows.join('\n')
}

export function downloadCSV(data, csvName = 'Table') {
  const csvData = generateCsvString(data)
  var blob = new Blob([csvData], { type: 'text/csv' })
  if (window.navigator && window.navigator.msSaveOrOpenBlob) {
    // for IE
    window.navigator.msSaveOrOpenBlob(csvData, csvName)
  }
  var blobURL = window.URL.createObjectURL(blob)
  var link = document.createElement('a')
  link.setAttribute('href', blobURL)
  link.setAttribute('download', csvName + '.csv')
  link.setAttribute('tabindex', '0')
  link.innerHTML = ''
  document.body.appendChild(link)
  link.click()
}


