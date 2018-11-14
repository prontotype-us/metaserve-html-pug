fs = require 'fs'
pug = require 'pug'
path = require 'path'

VERBOSE = process.env.METASERVE_VERBOSE?

module.exports =
    ext: 'pug'

    default_config:
        content_type: 'text/html'

    compile: (filename, config, context, cb) ->
        console.log '[PugCompiler.compile]', filename, config if VERBOSE

        fs.readFile filename, (err, file_str) ->
            filename = path.join config.static_dir, '_.pug'
            pug_compiler = pug.compile file_str, {filename}
            html = pug_compiler(context)

            cb err, {
                content_type: config.content_type
                source: file_str
                compiled: html
            }

