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
        WebDataObject.fromSiteMap(
            'https://docs.aws.amazon.com/bedrock/latest/userguide/sitemap.xml'),
        WebDataObject.fromWebPage(
            'https://community.aws/content/2dfsFaiclx8gTDbEaPDae9aTBVN/amazon-bedrock-golang-getting-started'),
        WebDataObject.fromWebPage(
            'https://community.aws/concepts/amazon-bedrock-golang-getting-started'),
        WebDataObject.fromWebPage(
            'https://community.aws/posts/amazon-bedrock-developing-java-applications'),
        WebDataObject.fromWebPage(
            'https://community.aws/posts/amazon-bedrock-quick-start'),
        WebDataObject.fromGithub(
            'https://github.com/aws-samples/amazon-bedrock-workshop',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/build-on-aws/amazon-bedrock-go-sdk-examples',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/build-on-aws/amazon-bedrock-java-examples',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/build-on-aws/java-fm-playground', accessToken),
        WebDataObject.fromGithub(
            'https://github.com/build-on-aws/llm-rag-vectordb-python',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/build-on-aws/python-fm-playground',
            accessToken),
        WebDataObject.fromGithub(
            'https://github.com/build-on-aws/elevating-customer-support-with-rag-langchain-agent-bedrock-dynamodb-and-kendra',
            accessToken)
      ];
}
