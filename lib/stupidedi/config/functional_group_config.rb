module Stupidedi
  module Config

    #
    # The functional group segments (GS/GE) and the segments contained by that
    # functional group are versioned separately from the interchange control
    # segments (ISA/ISE). The functional group version is informally referred to
    # as the EDI version (5010, 4010, etc). Each version indicates the segment
    # dictionary being used and the grammar of the functional group. Only the GS
    # and GE segments are described in the HIPAA guides, but the functional
    # group header and footer may consist of other segments.
    #
    # Because the interchange and functional group are versioned independently,
    # it may be possible, for instance, to send a 4010 transaction set within a
    # 5010 envelope, depending on forward- and backward-comatibility.
    #
    # @see http://x12.org/rfis/ "Relations Between the ISA and GS Segments.PDF"
    #
    class FunctionalGroupConfig
      def initialize
        @table = Hash.new
      end

      def register(version, &constructor)
        @table[version] = constructor
      end

      def at(version)
        @table[version].call
      end

      def defined_at?(version)
        @table.defined_at?(version)
      end

      # @return [void]
      def pretty_print(q)
        q.text "FunctionalGroupConfig"
        q.group 2, "(", ")" do
          q.breakable ""
          @table.keys.each do |e|
            unless q.current_group.first?
              q.text ","
              q.breakable
            end
            q.pp e
          end
        end
      end
    end

  end
end
