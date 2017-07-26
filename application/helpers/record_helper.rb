# frozen_string_literal: true

module RecordHelper
  RecordFile = "#{RubyRPG::Settings::ROOT}/application/data/record.json"

  def records
    JSON.parse_file RecordFile
  end

  def read_record(id)
    records.query_id id
  end

  def write_record(id, hash)
    current_record = records
    query_record = current_record.query_id(id)
    if query_record.nil?
      hash[:id] = current_record.last ? current_record.last.id.next : 1
      hash[:character][:id] = hash[:id]
      File.open(RecordFile, 'w') { |file| file.write(current_record.push(hash).to_json) }
    else
      hash[:id] = id
      current_record[current_record.index(query_record)] = hash
      File.open(RecordFile, 'w') { |file| file.write(current_record.to_json) }
    end
  end
end
