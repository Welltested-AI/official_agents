import 'dart:io';

import 'package:dash_agent/data/datasource.dart';
import 'package:dash_agent/data/objects/project_data_object.dart';
import 'package:dash_agent/data/objects/file_data_object.dart';
import 'package:dash_agent/data/objects/web_data_object.dart';

/// [DocsDataSource] indexes all the documentation related data and provides it to commands.
class DocsDataSource extends DataSource {
  final accessToken = '';
  @override
  List<FileDataObject> get fileObjects => [];

  @override
  List<ProjectDataObject> get projectObjects => [];

  @override
  List<WebDataObject> get webObjects => [
        WebDataObject.fromSiteMap('https://www.gitpod.io/sitemap.xml'),
        WebDataObject.fromWebPage(
            'https://github.com/dabit3/polygon-ethereum-nextjs-marketplace/blob/main/.gitpod.yml'),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/spring-petclinic', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-typescript-react',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-golang-cli',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/demo-aws-with-gitpod',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-python-django',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/kotlin-ktor-chat', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/persistent-volume-mount',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/gitpod-backstage-demo',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-flutter', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-ruby-on-rails-postgres',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-dotnet-core-cli-csharp',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/angular-sample', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/EventHub', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-quarkus', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/docker-getting-started-app',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/cypress-sample', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-wordpress',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-jupyter-notebook',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-x11-vnc', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-sveltekit',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-fastify', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-python-flask',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-nextjs', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-php-laravel-mysql',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/rust-hello-world', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-bun', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-ocaml', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-dbt-bigquery',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-cpp', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-ihp', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/demo-dotfiles-with-gitpod',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-samples/template-haskell', accessToken),

        /// Awesome Gitpod
        WebDataObject.fromGithub(
            'https://github.com/Derroylo/shopware-workspace-sample',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/gitpod-io/template-python-flask-tabnine',
            accessToken),
      ];
}
