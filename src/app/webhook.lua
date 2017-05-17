--
-- Copyright (C) 2016 iMega ltd Dmitry Gavriloff (email: info@imega.ru),
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.

--local json = require "cjson"
--local sha1 = require "sha1"
--
--ngx.req.read_body()
--local body = ngx.req.get_body_data()
--
--local jsonErrorParse, data = pcall(json.decode, body)
--if not jsonErrorParse then
--    ngx.status = ngx.HTTP_BAD_REQUEST
--    ngx.say("400 HTTP_BAD_REQUEST " + jsonErrorParse)
--    ngx.exit(ngx.status)
--end
--
--if data.action ~= "closed" or data.pull_request.merged == false then
--    ngx.status = ngx.HTTP_OK
--    ngx.say("200 HTTP_OK")
--    ngx.exit(ngx.status)
--end

ngx.status = ngx.HTTP_OK
ngx.say("200 HTTP_OK Start deploy")
ngx.eof()

os.execute("cd /tmp; git clone https://github.com/ippart/backend.git; cd /tmp/backend; make deploy; cd /;rm -rf /tmp/backend")
