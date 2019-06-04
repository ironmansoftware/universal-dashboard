var webpack = require('webpack');
var path = require('path');

var BUILD_DIR = path.resolve(__dirname, 'public');
var SRC_DIR = path.resolve(__dirname);
var APP_DIR = path.resolve(__dirname, 'src/app');

module.exports = (env) => {
  const isDev = env == 'development' || env == 'isolated';

  return {
    entry: {
      'index' : __dirname + '/components/index.js'
    },
    output: {
      path: BUILD_DIR,
      filename: isDev ? 'materialize.[name].bundle.js' : '[name].[hash].bundle.js',
      sourceMapFilename: '[name].[hash].bundle.map',
      publicPath: "/",
      library: 'udmaterialize',
      libraryTarget: 'var'
    },
    module : {
      rules : [
        { test: /\.css$/, loader: "style-loader!css-loader" },
        { test: /\.(js|jsx)$/, exclude: [/node_modules/, /public/], loader: 'babel-loader'},
        { test: /\.(eot|ttf|woff2?|otf|svg)$/, loader:'file-loader' }
      ]
    },
    externals: {
      UniversalDashboard: 'UniversalDashboard',
      $: "$",
      'react': 'react',
      'react-router-dom': 'reactrouterdom'
    },
    resolve: {
      extensions: ['.json', '.js', '.jsx']
    },
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

