#-*- coding: utf-8 -*-
require 'spec_helper'

describe MetaGraph::Client do
  before do
    @client = MetaGraph::Client.new(MetaGraph::RSPEC_ACCESS_TOKEN)
  end

  it 'should read the access token from client' do
    @client.access_token.should == MetaGraph::RSPEC_ACCESS_TOKEN
  end

  context 'when get a connection from Graph API' do
    before do
      regist_mock 'me/likes'
      @likes = @client.get('me/likes')
    end

    it 'should access collection' do
      @likes.should have(106).items
    end
  end

  context 'when get a data from Graph API' do
    before do
      regist_mock :me
      @me = @client.me
    end

    it "should access user's string fields" do
      @me.id.should   == '100001529256922'
      @me.name.should == 'Kengo Tateishi'
    end

    context 'when access collections' do
      before do
        regist_mock 'me/likes'
        @likes = @me.likes
      end

      it 'should get collection size' do
        @likes.should have(106).items
      end

      context 'when read a value contained id key' do
        before do
          regist_mock '116314101712416'
          @like = @likes[90]
        end

        it 'should get specified collection' do
          @like.id.should == '116314101712416'
          @like.name.should == 'となりのトトロ'
        end
      end
    end

    context 'when read a array value' do
      before do
        @works = @me.work
        @favorite_teams = @me.favorite_teams
      end

      it 'should access users array parameter' do
        @works.should have(4).items
        @favorite_teams.should have(1).item
      end

      context 'when read a value contained id key' do
        before do
          regist_mock '164489816910252'
          @employer = @works[0].employer
        end

        it 'should read a value from Graph API' do
          @employer.id.should == '164489816910252'
          @employer.name.should == 'Paperboy&co.'
          @employer.location.zip.should == '1508512'
          @employer.location.country.should == 'Japan'
        end
      end
    end

    context 'when read a value contained id key' do
      before do
        regist_mock '125808504153906'
        @hometown = @me.hometown
      end

      it 'should access fields of its data' do
        @hometown.id.should == '125808504153906'
        @hometown.name.should == 'Tosu-shi, Saga, Japan'
        @hometown.link.should == 'https://www.facebook.com/pages/Tosu-shi-Saga-Japan/125808504153906' 
      end
    end
  end
end
