var webpack = require('webpack');
var path = require('path');

var BUILD_DIR = path.resolve(__dirname, 'public');
var SRC_DIR = path.resolve(__dirname);
var APP_DIR = path.resolve(__dirname, 'src/app');

process.env.NODE_ENV = 'production'

module.exports = (env) => {
  const isDev = env == 'development' || env == 'isolated';

  return {
    entry: {
      'index': __dirname + '/JavaScript/index.js'
    },
    output: {
      path: BUILD_DIR,
      filename: isDev ? '[name].bundle.js' : '[name].[hash].bundle.js',
      sourceMapFilename: '[name].[hash].bundle.map',
      publicPath: "",
      library: '$Name',
      libraryTarget: 'var'
    },
    module: {
      rules: [{
          test: /\.(js|jsx)$/,
          exclude: [/node_modules/, /public/],
          use: ['babel-loader']
        },
        {
          test: /\.css$/,
          loader: 'css-loader',
        },
        {
          test: /\.(eot|ttf|woff2?|otf|svg)$/,
          loader: 'file-loader'
        }
      ]
    },
    optimization: {
      nodeEnv: "production",
      splitChunks: {
        chunks: "async",
        minSize: 30000,
        maxSize: 0,
        minChunks: 1,
        maxAsyncRequests: 5,
        maxInitialRequests: 3,
        automaticNameDelimiter: "-",
        automaticNameMaxLength: 15,
        name: true,
      },
      removeEmptyChunks: true,
      noEmitOnErrors: false,
    },
    externals: {
      UniversalDashboard: 'UniversalDashboard',
      $: "$",
      'react': 'react',
      'react-dom': 'reactdom',
      'react-router-dom': 'reactrouterdom'
    },
    resolve: {
      extensions: ['.json', '.js', '.jsx'],
    },
    plugins: [
      // new RemoveWebpackPlugin(BUILD_DIR)
    ],
    devtool: "source-map",
    devServer: {
      disableHostCheck: true,
      historyApiFallback: true,
      port: 10000,
      // hot: true,
      compress: true,
      publicPath: '/',
      stats: "minimal"
    },
  };
}