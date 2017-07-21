# frozen_string_literal: true

module RecordHelper
  RecordFile = "#{RubyRPG::Settings::ROOT}/application/data/record.json"
  RecordDirectory = "#{RubyRPG::Settings::ROOT}/application/records"

  def records
    JSON.parse_file RecordFile
  end

  def read_record(id)
    records.query_id id
  end

  def write_record(id, hash)
    current_record = records
    if current_record.query_id(id).nil?
      hash[:id] = current_record.last ? current_record.last.id.next : 1
      File.open(RecordFile, 'w') { |file| file.write(current_record.push(hash).to_json) }
    else
      # Old record
    end
    # id ||= generate_new_record_file
    # File.open("#{RecordDirectory}/record_#{id}.json", 'w') { |file| file.write(content) }
  end

  # def generate_new_record_file
  #   id = Dir.file_counts("#{RecordDirectory}/*.json").next
  #   system "touch '#{RecordDirectory}/record_#{id}.json'"
  #   id
  # end
end
