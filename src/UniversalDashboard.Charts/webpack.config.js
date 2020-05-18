var webpack = require('webpack');
var path = require('path');

var BUILD_DIR = path.resolve(__dirname, 'output');
var SRC_DIR = path.resolve(__dirname);
var APP_DIR = path.resolve(__dirname, 'src/app');

module.exports = (env) => {
  const isDev = env == 'development' || env == 'isolated';

  return {
    entry: {
      'udcharts' : __dirname + '/components/index.js'
    },
    output: {
      library: "UDCharts",
      libraryTarget: "var",
      path: BUILD_DIR,
      filename: isDev ? '[name].bundle.js' : '[name].[hash].bundle.js',
      sourceMapFilename: '[name].[hash].bundle.map',
      publicPath: "/"
    },
    module : {
      rules : [
        { test: /\.(js|jsx)$/, exclude: [/node_modules/, /public/], loader: 'babel-loader'}
      ]
    },
    externals: {
      UniversalDashboard: 'UniversalDashboard',
      'react': 'react',
      'react-dom': 'reactdom'
    },
    resolve: {
      extensions: ['.json', '.js', '.jsx']
    },
    //new webpack.optimize.UglifyJsPlugin()
    devtool: 'source-map',
    devServer: {
      disableHostCheck: true,
      historyApiFallback: true,
      port: 10000,
      // hot: true,
      compress:true,
      publicPath: '/',
      stats: "minimal"
    },
  };
}

