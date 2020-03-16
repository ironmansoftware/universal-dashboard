export const getAggregate = (dataView, operations = [], fields = [], as = []) =>
  [dataView].transform({
    type: 'aggregate',
    fields: fields,
    operations: operations,
    as: as,
  })

export function downloadCSV(csvString, csvName = 'Table') {
  var blob = new Blob([csvString], { type: 'text/csv;charset=utf-8;' })
  var blobURL = window.URL.createObjectURL(blob)
  var link = document.createElement('a')
  link.setAttribute('href', blobURL)
  link.setAttribute('download', csvName + '.csv')
  link.setAttribute('tabindex', '0')
  link.innerHTML = ''
  document.body.appendChild(link)
  link.click()
}

export function parseTimeInput(inputString = '') {
  inputString = inputString.toLowerCase()
  let getNumber = (inputString, charsFromEnd) => {
    let startAt =
      inputString.indexOf('pt') !== -1
        ? 2
        : inputString.indexOf('p') !== -1
        ? 1
        : 0
    return Number(inputString.slice(startAt, inputString.length - charsFromEnd))
  }
  if (inputString.indexOf('ms') == inputString.length - 2) {
    return getNumber(inputString, 2)
  }
  if (inputString.indexOf('s') == inputString.length - 1) {
    return getNumber(inputString, 1) * 1000
  }
  if (inputString.indexOf('m') == inputString.length - 1) {
    return getNumber(inputString, 1) * 60 * 1000
  }
  if (inputString.indexOf('h') == inputString.length - 1) {
    return getNumber(inputString, 1) * 60 * 60 * 1000
  }
  if (inputString.indexOf('d') == inputString.length - 1) {
    return getNumber(inputString, 1) * 24 * 60 * 60 * 1000
  }
  return -1
}
