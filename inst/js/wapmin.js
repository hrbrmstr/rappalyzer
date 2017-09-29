var asArray = function(value) {
  return typeof value === 'string' ? [value] : value;
};

var parsePatterns = function(patterns) {

  var parsed = {};

  // Convert string to object containing array containing string
  if (typeof patterns === 'string' || patterns instanceof Array) {
    patterns = {
      main: asArray(patterns)
    };
  }

  for (var key in patterns) {
    parsed[key] = [];

    asArray(patterns[key]).forEach(function(pattern) {
      var attrs = {};

      pattern.split('\\;').forEach(function(attr, i) {
        if (i) {
          // Key value pairs
          attr = attr.split(':');

          if (attr.length > 1) {
            attrs[attr.shift()] = attr.join(':');
          }
        } else {
          attrs.string = attr;

          try {
            attrs.regex = new RegExp(attr.replace('/', '\/'), 'i'); // Escape slashes in regular expression
          } catch (e) {
            attrs.regex = new RegExp();

            //console.log(e + ': ' + attr, 'error', 'core');
          }
        }
      });

      parsed[key].push(attrs);

    });
  }

  // Convert back to array if the original pattern list was an array (or string)
  if ('main' in parsed) {
    parsed = parsed.main;
  }

  return parsed;

};

/**
 * Mark application as detected, set confidence and version
 */
var addDetected = function(app, pattern, type, value, key) {

  app.detected = true;

  app.match_type = type;

  // Set confidence level
  app.confidence[type + ' ' + (key ? key + ' ' : '') + pattern.regex] = pattern.confidence || 100;

  // Detect version number
  if (pattern.version) {

    var versions = [];
    var version = pattern.version;
    var matches = pattern.regex.exec(value);

    if (matches) {
      matches.forEach(function(match, i) {
        // Parse ternary operator
        var ternary = new RegExp('\\\\' + i + '\\?([^:]+):(.*)$').exec(version);

        if (ternary && ternary.length === 3) {
          version = version.replace(ternary[0], match ? ternary[1] : ternary[2]);
        }

        // Replace back references
        version = version.replace(new RegExp('\\\\' + i, 'g'), match || '');
      });

      if (version && versions.indexOf(version) === -1) {
        versions.push(version);
      }

      if (versions.length) {
        // Use the longest detected version number
        app.version = versions.reduce(function(a, b) {
          a.length > b.length ? a : b;
        });
      }
    }
  }

  found.push(app);

};

var analyzeHtml = function(app, html) {

  var patterns = parsePatterns(app.props.html);

  if (patterns.length) {
    patterns.forEach(function(pattern) {
      if (pattern.regex.test(html)) {
        addDetected(app, pattern, 'html', html);
      }
    });
  }
};

var analyzeScript = function(app, html) {

  var regex = new RegExp('<script[^>]+src=("|\')([^"\']+)', 'ig');
  var patterns = parsePatterns(app.props.script);

  if (patterns.length) {
    patterns.forEach(function(pattern) {
      var match;
      while ((match = regex.exec(html))) {
        if (pattern.regex.test(match[2])) {
          addDetected(app, pattern, 'script', match[2]);
        }
      }
    });
  }
};

var analyzeMeta = function(app, html) {

  var regex = /<meta[^>]+>/ig;
  var patterns = parsePatterns(app.props.meta);
  var content;
  var match;

  while (patterns && (match = regex.exec(html))) {
    for (var meta in patterns) {
      if (new RegExp('(name|property)=["\']' + meta + '["\']', 'i').test(match)) {
        content = match.toString().match(/content=("|')([^"']+)("|')/i);
        patterns[meta].forEach(function(pattern) {
          if (content && content.length === 4 && pattern.regex.test(content[2])) {
            addDetected(app, pattern, 'meta', content[2], meta);
          }
        });
      }
    }
  }
};


var analyzeHeaders = function(app, headers) {

  var patterns = parsePatterns(app.props.headers);
  var header;

  if (headers) {
    Object.keys(patterns).forEach(function(header) {
      patterns[header].forEach(function(pattern) {
        header = header.toLowerCase();
        if (header in headers && pattern.regex.test(headers[header])) {
          addDetected(app, pattern, 'headers', headers[header], header);
        }
      });
    });
  }
};

var analyzeUrl = function(app, url) {

  var patterns = parsePatterns(app.props.url);

  if (patterns.length) {
    patterns.forEach(function(pattern) {
      if (pattern.regex.test(url)) {
        addDetected(app, pattern, 'url', url);
      }
    });
  }
};

var analyze = function(url, html, headers) {

  var myapps = apps;

  Object.keys(myapps).forEach(function(appName) {

    myapps[appName] = {
      confidence: {},
      confidenceTotal: 0,
      detected: false,
      excludes: [],
      name: appName,
      props: myapps[appName],
      version: ''
    };

    var app = myapps[appName];

    analyzeUrl(app, url);
    analyzeHtml(app, html);
    analyzeScript(app, html);
    analyzeMeta(app, html);
    analyzeHeaders(app, headers);

  });

};