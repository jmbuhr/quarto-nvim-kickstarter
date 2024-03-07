-- read from the Zotero databaes to one day generate citations
-- and populate the local requirements.bib file
local sql = {}

-- Open db file at path or environment variable, otherwise open in memory.
local db = require('sqlite.db'):open('~/Zotero/zotero.sqlite', { open_mode = 'ro' })

local resp_collection_names = db:eval [[
            SELECT collections.collectionName
            FROM collections
]]

M = {}
M._creators = {
  'editor',
  'seriesEditor',
  'translator',
  'reviewedAuthor',
  'artist',
  'performer',
  'composer',
  'director',
  'podcaster',
  'cartographer',
  'programmer',
  'presenter',
  'interviewee',
  'interviewer',
  'recipient',
  'sponsor',
  'inventor',
}

local collections = {}
for _, c in ipairs(resp_collection_names) do
  collections[c['collectionName']] = {}
end

local resp_collections = db:eval [[
            SELECT items.itemID, collections.collectionName
            FROM items, collections, collectionItems
            WHERE
                items.itemID = collectionItems.itemID
                and collections.collectionID = collectionItems.collectionID
            ORDER by collections.collectionName
]]

for _, item in ipairs(resp_collections) do
  table.insert(collections[item['collectionName']], item['itemID'])
end

local resp_fields = db:eval [[
            SELECT items.itemID, items.key, fields.fieldName, itemDataValues.value
            FROM items, itemData, fields, itemDataValues
            WHERE
                items.itemID = itemData.itemID
                and itemData.fieldID = fields.fieldID
                and itemData.valueID = itemDataValues.valueID
]]

local items = {}

for _, item in ipairs(resp_fields) do
  if not items[item['itemID']] then
    items[item['itemID']] = { zotkey = item['key'], alastnm = '' }
  end
  items[item['itemID']][item['fieldName']] = item['value']
end

local resp_authors = db:eval [[
            SELECT items.itemID, creatorTypes.creatorType, creators.lastName, creators.firstName
            FROM items, itemCreators, creators, creatorTypes
            WHERE
                items.itemID = itemCreators.itemID
                and itemCreators.creatorID = creators.creatorID
                and creators.creatorID = creators.creatorID
                and itemCreators.creatorTypeID = creatorTypes.creatorTypeID
            ORDER by itemCreators.ORDERIndex
]]

for _, author in ipairs(resp_authors) do
  if items[author['itemID']] then
    if items[author['itemID']][author['creatorType']] then
      table.insert(items[author['itemID']][author['creatorType']], { author['lastName'], author['firstName'] })
    else
      items[author['itemID']][author['creatorType']] = { { author['lastName'], author['firstName'] } }
    end
    if author['creatorType'] == 'author' then
      items[author['itemID']]['alastnm'] = items[author['itemID']]['alastnm'] .. ', ' .. author['lastName']
    else
      local sought = { 'author' }
      for _, c in ipairs(M._creators) do
        if author['creatorType'] == c then
          local flag = false
          for _, s in ipairs(sought) do
            if items[author['itemID']][s] then
              flag = true
              break
            end
          end
          if not flag then
            items[author['itemID']]['alastnm'] = items[author['itemID']]['alastnm'] .. ', ' .. author['lastName']
          end
        end
        table.insert(sought, c)
      end
    end
  end
end

-- generate citation keys
for _, item in ipairs(items) do
  local authors = item['author']
  local author = ''
  if authors ~= nil then
    author = authors[1][1]
  end
  local year = ''
  local date = item['date']
  if date ~= nil then
    year = string.match(date, '%d%d%d%d')
  end
  local title = item['title']
  title = string.sub(title, 1, 10)
  local key = author .. title .. year
  key = string.gsub(key, '[^%w]', '')
  item['citekey'] = key
end

local resp_types = db:eval [[
            SELECT items.itemID, itemTypes.typeName
            FROM items, itemTypes
            WHERE
                items.itemTypeID = itemTypes.itemTypeID
]]

for _, item in ipairs(resp_types) do
  if items[item['itemID']] then
    if item['typeName'] == 'attachment' then
      items[item['itemID']] = nil
    else
      items[item['itemID']]['etype'] = item['typeName']
    end
  end
end

vim.print(items)
